const { ethers } = require('hardhat');
const { verifyContract } = require('hardhat-etherscan-verify');
require('dotenv').config();

const { ETHERSCAN_API_KEY } = process.env;

async function deployEscrowContract() {
  const [deployer] = await ethers.getSigners();

  console.log('Deploying Escrow contract...');
  const Escrow = await ethers.getContractFactory('Escrow');
  const escrow = await Escrow.deploy();

  await escrow.deployed();

  console.log('Escrow contract deployed to:', escrow.address);
  return escrow.address;
}

async function verifyEscrowContract(contractAddress) {
  await verifyContract({
    address: contractAddress,
    contractName: 'Escrow',
    etherscanApiKey: ETHERSCAN_API_KEY,
    hardhatArguments: [], // Add constructor arguments if any
  });

  console.log('Escrow contract verified on Etherscan!');
}

// Usage
async function main() {
  const contractAddress = await deployEscrowContract();
  await verifyEscrowContract(contractAddress);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
