# Idle Investor - Web3 Game

A blockchain-based idle game where players invest in properties to earn passive income.

## Features

- 🎮 **Wallet Login**: Connect with MetaMask or other Web3 wallets
- 🎨 **Investor NFT**: Each player receives a unique Investor NFT upon joining
- 💰 **Initial Tokens**: Get 100 INVEST tokens to start playing
- 🏠 **Properties**: Three types of properties (Basic, Medium, Premium)
- 📈 **Passive Income**: Properties generate tokens over time
- ♾️ **Stackable**: Buy multiple properties to increase earnings

## Game Economics

### Token Supply

- **Total Supply**: 1,000,000 INVEST tokens
- **Initial Player Balance**: 100 INVEST tokens

### Property Types

| Property | Price      | Rewards/Second |
| -------- | ---------- | -------------- |
| Basic    | 50 INVEST  | 0.001 INVEST   |
| Medium   | 200 INVEST | 0.005 INVEST   |
| Premium  | 500 INVEST | 0.015 INVEST   |

## Smart Contracts

### 1. InvestorToken (ERC20)

- Token name: "Investor Coin"
- Symbol: "INVEST"
- Fixed supply: 1,000,000 tokens

### 2. InvestorNFT (ERC721)

- NFT name: "Idle Investor"
- Symbol: "INVESTOR"
- One NFT per player

### 3. IdleInvestorGame

- Main game logic
- Property management
- Reward distribution

## Setup & Installation

### Prerequisites

- Node.js v16 or higher
- npm or yarn

### Install Dependencies

```bash
npm install
```

### Compile Contracts

```bash
npm run compile
```

### Run Tests

```bash
npm test
```

### Deploy Locally

1. Start a local Hardhat node:

```bash
npm run node
```

2. In a new terminal, deploy contracts:

```bash
npm run deploy:local
```

### Deploy to Testnet

1. Copy `.env.example` to `.env`:

```bash
cp .env.example .env
```

2. Fill in your values in `.env`:

- `SEPOLIA_RPC_URL`: Your Alchemy/Infura RPC URL
- `PRIVATE_KEY`: Your wallet private key (with testnet ETH)

3. Deploy:

```bash
npm run deploy:testnet
```

### Related Repositories
- Frontend (React): [https://github.com/Soarbh-Srivastava/idle-investor-frontend](https://github.com/Soarbh-Srivastava/web3-ideal-investor-game-frontend)
- Backend (Node.js): [https://github.com/Soarbh-Srivastava/idle-investor-backend](https://github.com/Soarbh-Srivastava/web3-game-idle-investor-backend)


## Next Steps

1. ✅ Smart Contracts (Complete)
2. ⏳ Node.js Backend (Next)
3. ⏳ Frontend (After backend)

## License

MIT
