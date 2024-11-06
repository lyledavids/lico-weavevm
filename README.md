# Lico: A Web3 TikTok Platform

## Introduction
Lico is a decentralized social media platform inspired by TikTok, built on web3 technologies and blockchain to empower content creators.

## Key Features
- User-created profiles with customizable avatars and bios
- Video uploads with Arweave for decentralized, permanent hosting
- Commenting and liking functionality
- Following and unfollowing other users
- Monetization through tipping or subscription models (future feature)

## Technology Stack
- Solidity smart contract for managing user profiles, videos, and interactions
- SvelteKit for the front-end application
- Ethers.js for web3 integration and interacting with the smart contract
- Arweave for decentralized video storage
- Tailwind CSS for responsive and modern UI styling

## Smart Contract Overview
The Solidity smart contract handles the following functionalities:
- User profiles, including username, bio, and avatar
- Video uploads, likes, comments, and metadata
- Tracking user followers and following
- Pausing and unpausing the contract for maintenance

## Frontend Architecture
The frontend of Lico is built using SvelteKit, which provides server-side rendering and static site generation. The application uses Svelte stores for state management, including web3 and user data. Reusable UI components are implemented for the video feed, video cards, and profile pages, seamlessly integrating with the smart contract through Ethers.js.

## Deployment and Storage
The Lico project is currently in development and has not yet been deployed. After the initial deployment, the plan is to switch the video storage from Arweave to using WeaveVM procompiles which stores on Arweave directly from solidity, which will allow for increased data limits and improved performance.

## Future Roadmap
- Implement tipping and subscription-based monetization for creators
- Develop advanced video discovery and recommendation algorithms
- Explore cross-chain functionality for broader user accessibility

## Conclusion
Lico aims to revolutionize social media by empowering creators and users through the use of web3 technologies. By creating a more transparent and decentralized platform, Lico provides users with greater control over their content and data, fostering a vibrant community of content creators and engaged viewers.