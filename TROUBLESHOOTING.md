# 🔧 Troubleshooting Guide - Join Game Failed

## Common Issues and Solutions

### 1. **"Contract address not configured"**

**Problem:** Game contract address is not loaded in the frontend

**Solutions:**

- Make sure `.env` file in `frontend/` folder has:
  ```
  NEXT_PUBLIC_GAME_ADDRESS=0xB172bDbC20f4286242501E6567faBEAb666434d9
  NEXT_PUBLIC_TOKEN_ADDRESS=0x5BCE976D67A20D59c22dF0BEF7B2b9d5a486fDc0
  NEXT_PUBLIC_NFT_ADDRESS=0xD80891da601B45684a91d83DE91b6EA204A56579
  ```
- **Restart the frontend:** Kill it and run `npm run dev` again
- Check that the addresses are correct (copy from deployment output or root `.env`)

### 2. **"Transaction rejected by user"**

**Problem:** You declined the transaction in MetaMask

**Solutions:**

- Click "Join Game" again and **approve** the transaction in MetaMask
- Make sure you're looking at MetaMask notification carefully

### 3. **"Connection error - check your network"**

**Problem:** Cannot connect to Sepolia testnet

**Solutions:**

- Check MetaMask is **connected to Sepolia testnet**:
  - Click network dropdown in MetaMask
  - Select "Sepolia" (or add if not present)
- Verify you have **Sepolia ETH** for gas fees:
  - Get free Sepolia ETH from: https://sepoliafaucet.com/
  - Or: https://www.alchemy.com/faucets/ethereum-sepolia
- Make sure you're using the **same wallet** for frontend

### 4. **"You have already joined the game"**

**Problem:** This wallet address already joined previously

**Solutions:**

- Use a different wallet address in MetaMask
- Import a new test account with different private key
- Or reset this wallet's transaction history (if using test account)

### 5. **Transaction taking too long / Stuck**

**Problem:** Transaction seems to hang indefinitely

**Solutions:**

- Check Sepolia Etherscan to see transaction status:
  - Go to https://sepolia.etherscan.io/
  - Search your wallet address
  - Look for your transaction
- If transaction failed:
  - Try joining again
  - Check you have enough Sepolia ETH for gas
- Try resetting MetaMask:
  - Settings → Advanced → Clear activity & nonce data

### 6. **"Please connect your wallet first"**

**Problem:** Wallet not connected to the app

**Solutions:**

- Click the "Connect Wallet" button in top right
- Follow MetaMask prompts to connect
- Make sure MetaMask is **on Sepolia testnet**

---

## Debugging Checklist

Before joining the game, verify:

- ✅ **MetaMask connected** - Check top right corner of app
- ✅ **Correct network** - MetaMask should show "Sepolia"
- ✅ **Sufficient ETH** - Show ~0.01-0.05 Sepolia ETH in MetaMask
- ✅ **Frontend restarted** - After changing `.env` file
- ✅ **Backend running** - Should see "Server running on port 3000"
- ✅ **Contract addresses correct** - Check browser console (F12) for errors

---

## Check Browser Console for Errors

1. Open browser DevTools: **F12** or **Ctrl+Shift+I**
2. Go to **Console** tab
3. Look for error messages starting with "Error joining game:"
4. Copy the error and check the solutions above

---

## Need More Help?

### Check Transaction on Etherscan

1. Get your wallet address from MetaMask
2. Go to https://sepolia.etherscan.io/
3. Search your address
4. Look for failed transactions and error messages

### Verify Backend is Running

Run in backend terminal:

```bash
curl http://localhost:3000/health
```

Should return:

```json
{ "status": "OK", "timestamp": "..." }
```

### Verify Contracts Deployed

Go to Sepolia Etherscan and search for these addresses:

- Token: `0x5BCE976D67A20D59c22dF0BEF7B2b9d5a486fDc0`
- NFT: `0xD80891da601B45684a91d83DE91b6EA204A56579`
- Game: `0xB172bDbC20f4286242501E6567faBEAb666434d9`

---

## Quick Reset Steps

If everything is broken:

1. **Kill all node processes:**

   ```bash
   taskkill /F /IM node.exe
   ```

2. **Restart backend:**

   ```bash
   cd backend
   npm start
   ```

3. **Restart frontend:**

   ```bash
   cd frontend
   npm run dev
   ```

4. **Reload browser:** `Ctrl+Shift+R` (hard refresh)

5. **Reset MetaMask:**
   - Settings → Advanced → Clear activity data
   - Reconnect wallet to app

---

Happy Gaming! 🏢💰
