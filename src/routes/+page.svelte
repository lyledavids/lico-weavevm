<script lang="ts">
    import { onMount } from 'svelte';
    import { ethers } from 'ethers';
    import contractABI from '$lib/contractABI.json';
  
    let contract: ethers.Contract;
    let videos: any[] = [];
    let isLoading = true;
  
    const contractAddress = '';
  
    onMount(async () => {
      if (typeof window.ethereum !== 'undefined') {
        await connectWallet();
        await loadVideos();
        isLoading = false;
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
  
    async function loadVideos() {
      const videoCount = await contract.videoCount();
      videos = [];
      for (let i = 1; i <= videoCount; i++) {
        const video = await contract.getVideo(i);
        const user = await contract.getUser(video.author);
        videos.push({ ...video, username: user.username });
      }
    }
  
    async function likeVideo(videoId: number) {
      try {
        const tx = await contract.likeVideo(videoId);
        await tx.wait();
        await loadVideos();
      } catch (error) {
        alert('Error liking video: ' + error.message);
      }
    }
  </script>
  
  <svelte:head>
    <title>Lico</title>
  </svelte:head>
  
  <h1 class="text-3xl font-bold mb-6">Latest Videos</h1>
  
  {#if isLoading}
    <p class="text-center text-gray-600">Loading videos...</p>
  {:else}
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
      {#each videos as video}
        <div class="bg-white rounded-lg shadow-md overflow-hidden">
          <div class="p-4">
            <h3 class="text-xl font-semibold mb-2">Video #{video.id}</h3>
            <p class="text-gray-600 mb-2">By: {video.username}</p>
            <p class="text-gray-600 mb-4">Likes: {video.likes.toString()}</p>
            <div class="flex space-x-2">
              <button
                on:click={() => likeVideo(video.id)}
                class="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600 flex-grow"
              >
                Like
              </button>
              <a
                href={`https://arweave.net/${video.arweaveCID}`}
                target="_blank"
                rel="noopener noreferrer"
                class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 flex-grow text-center"
              >
                Watch
              </a>
            </div>
          </div>
        </div>
      {/each}
    </div>
  {/if}