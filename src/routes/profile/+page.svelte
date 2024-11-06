<script lang="ts">
    import { onMount } from 'svelte';
    import { ethers } from 'ethers';
    import contractABI from '$lib/contractABI.json';
  
    let contract: ethers.Contract;
    let address: string;
    let isRegistered = false;
    let username = '';
    let newUsername = '';
  
    const contractAddress = ''; 
  
    onMount(async () => {
      if (typeof window.ethereum !== 'undefined') {
        await connectWallet();
        await checkRegistration();
      } else {
        alert('Please install MetaMask to use this app');
      }
    });
  
    async function connectWallet() {
      await window.ethereum.request({ method: 'eth_requestAccounts' });
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      address = await signer.getAddress();
      contract = new ethers.Contract(contractAddress, contractABI, signer);
    }
  
    async function checkRegistration() {
      try {
        const user = await contract.getUser(address);
        isRegistered = true;
        username = user.username;
      } catch (error) {
        isRegistered = false;
      }
    }
  
    async function registerUser() {
      if (newUsername) {
        try {
          const tx = await contract.registerUser(newUsername);
          await tx.wait();
          isRegistered = true;
          username = newUsername;
          newUsername = '';
        } catch (error) {
          alert('Error registering user: ');
        }
      }
    }
  </script>
  
  <svelte:head>
    <title>Lico</title>
  </svelte:head>
  
  <h1 class="text-3xl font-bold mb-6">User Profile</h1>
  
  <div class="bg-white rounded-lg shadow-md p-6">
    {#if isRegistered}
      <h2 class="text-2xl font-semibold mb-4">Welcome, {username}!</h2>
      <p class="text-gray-600">Your Ethereum address: {address}</p>
    {:else}
      <h2 class="text-2xl font-semibold mb-4">Register Your Account</h2>
      <div class="mb-4">
        <label for="newUsername" class="block text-sm font-medium text-gray-700 mb-2">
          Choose a username
        </label>
        <input
          type="text"
          id="newUsername"
          bind:value={newUsername}
          placeholder="Enter username"
          class="w-full p-2 border rounded focus:ring-blue-500 focus:border-blue-500"
        />
      </div>
      <button
        on:click={registerUser}
        class="w-full bg-green-500 text-white p-2 rounded hover:bg-green-600"
      >
        Register
      </button>
    {/if}
  </div>