const hre = require("hardhat");

async function main() {
  console.log("Starting deployment...\n");

  // Get deployer account
  const [deployer] = await hre.ethers.getSigners();
  console.log("Deploying contracts with account:", deployer.address);

  const balance = await hre.ethers.provider.getBalance(deployer.address);
  console.log("Account balance:", hre.ethers.formatEther(balance), "ETH\n");

  // Deploy InvestorToken
  console.log("Deploying InvestorToken...");
  const InvestorToken = await hre.ethers.getContractFactory("InvestorToken");
  const investorToken = await InvestorToken.deploy();
  await investorToken.waitForDeployment();
  const tokenAddress = await investorToken.getAddress();
  console.log("InvestorToken deployed to:", tokenAddress);

  // Deploy InvestorNFT
  console.log("\nDeploying InvestorNFT...");
  const InvestorNFT = await hre.ethers.getContractFactory("InvestorNFT");
  const baseURI = "https://api.idle-investor.com/metadata/";
  const investorNFT = await InvestorNFT.deploy(baseURI);
  await investorNFT.waitForDeployment();
  const nftAddress = await investorNFT.getAddress();
  console.log("InvestorNFT deployed to:", nftAddress);

  // Deploy IdleInvestorGame
  console.log("\nDeploying IdleInvestorGame...");
  const IdleInvestorGame = await hre.ethers.getContractFactory(
    "IdleInvestorGame"
  );
  const game = await IdleInvestorGame.deploy(tokenAddress, nftAddress);
  await game.waitForDeployment();
  const gameAddress = await game.getAddress();
  console.log("IdleInvestorGame deployed to:", gameAddress);

  // Transfer token ownership to game contract
  console.log("\nTransferring token ownership to game contract...");
  await investorToken.transfer(gameAddress, await investorToken.totalSupply());
  console.log("Tokens transferred to game contract");

  // Transfer NFT ownership to game contract
  console.log("\nTransferring NFT ownership to game contract...");
  await investorNFT.transferOwnership(gameAddress);
  console.log("NFT ownership transferred to game contract");

  // Summary
  console.log("\n" + "=".repeat(60));
  console.log("DEPLOYMENT SUMMARY");
  console.log("=".repeat(60));
  console.log("InvestorToken:", tokenAddress);
  console.log("InvestorNFT:", nftAddress);
  console.log("IdleInvestorGame:", gameAddress);
  console.log("=".repeat(60));
  console.log("\nSave these addresses to your .env file!");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
