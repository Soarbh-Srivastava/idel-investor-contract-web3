# 🏢 Idle Investor - Complete Setup Guide

## Project Overview

A Web3 idle game where players invest in properties to earn passive income on the blockchain.

### Tech Stack

- **Smart Contracts**: Solidity, Hardhat, OpenZeppelin
- **Backend**: Node.js, Express, MongoDB, ethers.js
- **Frontend**: Next.js, React, RainbowKit, Wagmi, Tailwind CSS

---

## 📋 Prerequisites

Before starting, ensure you have:

- [Node.js](https://nodejs.org/) v16 or higher
- [MongoDB](https://www.mongodb.com/try/download/community) (local or Atlas)
- [MetaMask](https://metamask.io/) browser extension
- A code editor (VS Code recommended)

---

## 🚀 Quick Start

### Step 1: Install Dependencies

```bash
# Install root dependencies (smart contracts)
npm install

# Install backend dependencies
cd backend
npm install
cd ..

# Install frontend dependencies
cd frontend
npm install
cd ..
```

### Step 2: Set Up Environment Variables

#### Root `.env` (Smart Contracts)

```bash
cp .env.example .env
```

Edit `.env` - For local development, you can leave the default values.

#### Backend `.env`

```bash
cp backend/.env.example backend/.env
```

Edit `backend/.env`:

- Set `MONGODB_URI` to your MongoDB connection string
- Other values will be filled after deployment

#### Frontend `.env.local`

```bash
cp frontend/.env.local.example frontend/.env.local
```

Edit `frontend/.env.local`:

- Get `NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID` from https://cloud.walletconnect.com/
- Contract addresses will be filled after deployment

### Step 3: Deploy Smart Contracts

#### Start Local Blockchain

In a new terminal:

```bash
npm run node
```

Keep this terminal running. You'll see:

- Local blockchain running on http://127.0.0.1:8545
- Several test accounts with private keys

#### Deploy Contracts

In another terminal:

```bash
npm run deploy:local
```

You'll see output like:

```
InvestorToken deployed to: 0x5FbDB2315678afecb367f032d93F642f64180aa3
InvestorNFT deployed to: 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512
IdleInvestorGame deployed to: 0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0
```

**IMPORTANT**: Copy these addresses!

#### Update Environment Files

Add the contract addresses to:

**`backend/.env`**:

```env
TOKEN_ADDRESS=0x5FbDB2315678afecb367f032d93F642f64180aa3
NFT_ADDRESS=0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512
GAME_ADDRESS=0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0
```

**`frontend/.env.local`**:

```env
NEXT_PUBLIC_TOKEN_ADDRESS=0x5FbDB2315678afecb367f032d93F642f64180aa3
NEXT_PUBLIC_NFT_ADDRESS=0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512
NEXT_PUBLIC_GAME_ADDRESS=0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0
```

### Step 4: Configure MetaMask

1. Open MetaMask
2. Click network dropdown → Add Network → Add network manually
3. Fill in:
   - **Network Name**: Hardhat Local
   - **RPC URL**: http://127.0.0.1:8545
   - **Chain ID**: 1337
   - **Currency Symbol**: ETH
4. Import a test account:
   - Copy a private key from the Hardhat node terminal
   - MetaMask → Account menu → Import Account
   - Paste the private key

### Step 5: Start MongoDB

Make sure MongoDB is running:

```bash
# If using local MongoDB
mongod

# Or start MongoDB service (Windows)
net start MongoDB

# Or start MongoDB service (Mac/Linux)
sudo systemctl start mongod
```

### Step 6: Start Backend

In a new terminal:

```bash
cd backend
npm run dev
```

Backend will run on http://localhost:3000

### Step 7: Start Frontend

In a new terminal:

```bash
cd frontend
npm run dev
```

Frontend will run on http://localhost:3001

---

## 🎮 Playing the Game

1. Open http://localhost:3001 in your browser
2. Click "Connect Wallet" and select MetaMask
3. Connect your imported test account
4. Click "Join Game" to receive:
   - 1 Investor NFT
   - 100 INVEST tokens
5. Start buying properties!

### Game Mechanics

**Property Types:**

- 🏠 **Basic** - 50 INVEST - Earns 0.001 INVEST/second
- 🏢 **Medium** - 200 INVEST - Earns 0.005 INVEST/second
- 🏰 **Premium** - 500 INVEST - Earns 0.015 INVEST/second

**How to Play:**

1. Buy properties with your tokens
2. Properties generate passive income
3. Claim rewards regularly
4. Reinvest to grow your empire!

---

## 🧪 Testing

### Run Contract Tests

```bash
npm test
```

### Test Coverage

- Player registration
- Property purchases
- Rewards calculation
- Token transfers
- NFT minting

---

## 📁 Project Structure

```
idle-investor/
├── contracts/              # Smart contracts
│   ├── InvestorToken.sol  # ERC20 token
│   ├── InvestorNFT.sol    # ERC721 NFT
│   └── IdleInvestorGame.sol # Game logic
├── scripts/
│   └── deploy.js          # Deployment script
├── test/                  # Contract tests
├── backend/               # Node.js API
│   └── src/
│       ├── index.js       # Express server
│       ├── models/        # MongoDB models
│       ├── routes/        # API routes
│       └── services/      # Blockchain service
└── frontend/              # Next.js app
    ├── app/               # App router
    ├── components/        # React components
    ├── hooks/             # Custom hooks
    └── lib/               # Utilities
```

---

## 🔧 Troubleshooting

### Common Issues

**"Nonce too high" error in MetaMask**

- Settings → Advanced → Clear activity tab data

**Can't connect to blockchain**

- Ensure Hardhat node is running
- Check RPC URL is http://127.0.0.1:8545
- Verify Chain ID is 1337

**MongoDB connection failed**

- Check MongoDB is running
- Verify connection string in backend/.env

**Contract addresses not found**

- Redeploy contracts
- Update addresses in both .env files
- Restart backend and frontend

**Transactions failing**

- Check you have test ETH for gas
- Ensure you've joined the game first
- Verify contract addresses are correct

---

## 🚀 Deploying to Testnet

### 1. Get Testnet ETH

Get Sepolia ETH from:

- https://sepoliafaucet.com/
- https://www.alchemy.com/faucets/ethereum-sepolia

### 2. Update Root `.env`

```env
SEPOLIA_RPC_URL=https://eth-sepolia.g.alchemy.com/v2/YOUR_API_KEY
PRIVATE_KEY=your_wallet_private_key
```

### 3. Deploy to Sepolia

```bash
npm run deploy:testnet
```

### 4. Update Environment Files

Update backend and frontend .env files with new addresses and:

**Backend**:

```env
RPC_URL=https://eth-sepolia.g.alchemy.com/v2/YOUR_API_KEY
CHAIN_ID=11155111
```

**Frontend**:

```env
NEXT_PUBLIC_CHAIN_ID=11155111
NEXT_PUBLIC_RPC_URL=https://eth-sepolia.g.alchemy.com/v2/YOUR_API_KEY
NEXT_PUBLIC_ENABLE_TESTNETS=true
```

---

## 📊 API Endpoints

### Player

- `GET /api/player/:address` - Get player info
- `POST /api/player/join` - Record player join
- `GET /api/player/:address/stats` - Get statistics

### Game

- `GET /api/game/info` - Get game configuration
- `GET /api/game/leaderboard` - Top players
- `GET /api/game/rewards/:address` - Calculate rewards

### Property

- `GET /api/property/configs` - Property types
- `POST /api/property/purchase` - Record purchase
- `POST /api/property/claim` - Record claim

---

## 🎯 Next Steps

### Enhancements to Consider

1. **Game Features**

   - Property upgrades
   - Special events
   - Achievements/badges
   - Referral system

2. **Technical Improvements**

   - Add real-time updates with WebSockets
   - Implement caching (Redis)
   - Add comprehensive error logging
   - Set up CI/CD pipeline

3. **Security**

   - Add rate limiting per wallet
   - Implement anti-bot measures
   - Add transaction signing verification
   - Security audit for contracts

4. **UI/UX**
   - Add animations
   - Mobile app version
   - Dark/light theme toggle
   - Sound effects

---

## 📝 License

MIT

## 🤝 Contributing

Contributions welcome! Please read the contributing guidelines first.

## 📧 Support

For issues and questions:

- Create an issue on GitHub
- Check existing documentation
- Review the code comments

---

**Happy Building! 🏢💰**
