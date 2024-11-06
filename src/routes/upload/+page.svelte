<script lang="ts">
    import { onMount } from 'svelte';
    import { ethers } from 'ethers';
    import contractABI from '$lib/contractABI.json';
  
    let contract: ethers.Contract;
    let arweaveCID = '';
    let isUploading = false;
  
    const contractAddress = '';
  
    onMount(async () => {
      if (typeof window.ethereum !== 'undefined') {
        await connectWallet();
      } else {
        alert('Please install MetaMask to use this app');
      }
    });
  
    async function connectWallet() {
      await window.ethereum.request({ method: 'eth_requestAccounts' });
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      contract = new ethers.Contract(contractAddress, contractABI, signer);
    }
  
    async function uploadVideo() {
      if (arweaveCID) {
        try {
          isUploading = true;
          const tx = await contract.uploadVideo(arweaveCID);
          await tx.wait();
          arweaveCID = '';
          alert('Video uploaded successfully!');
        } catch (error) {
          alert('Error uploading video: ' + error.message);
        } finally {
          isUploading = false;
        }
      }
    }
  </script>
  
  <svelte:head>
    <title>Lico</title>
  </svelte:head>
  
  <h1 class="text-3xl font-bold mb-6">Upload Video</h1>
  
  <div class="bg-white rounded-lg shadow-md p-6">
    <div class="mb-4">
      <label for="arweaveCID" class="block text-sm font-medium text-gray-700 mb-2">
        Arweave CID
      </label>
      <input
        type="text"
        id="arweaveCID"
        bind:value={arweaveCID}
        placeholder="Enter Arweave CID"
        class="w-full p-2 border rounded focus:ring-blue-500 focus:border-blue-500"
      />
    </div>
    <button
      on:click={uploadVideo}
      disabled={isUploading}
      class="w-full bg-blue-500 text-white p-2 rounded hover:bg-blue-600 disabled:bg-blue-300"
    >
      {isUploading ? 'Uploading...' : 'Upload Video'}
    </button>
  </div>
  
  <div class="mt-6">
    <h2 class="text-xl font-semibold mb-4">How to upload a video:</h2>
    <ol class="list-decimal list-inside space-y-2">
      <li>Upload your video to Arweave (you can use a service like ardrive.io)</li>
      <li>Copy the Arweave transaction ID (CID) of your uploaded video</li>
      <li>Paste the CID into the input field above</li>
      <li>Click the "Upload Video" button to add your video to Lico</li>
    </ol>
  </div>