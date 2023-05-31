const { ethers, upgrades, run } = require('hardhat');
const { verifyContract } = require('@nomiclabs/hardhat-etherscan');

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
  const network = await ethers.provider.getNetwork();
  const networkName = network.name;

  if (networkName === 'sepolia') {
    await run('verify:verify', {
      address: contractAddress,
      contract: 'contracts/Escrow.sol', // Path to your contract
      constructorArguments: [], // Add constructor arguments if any
    });

    console.log('Escrow contract verified on Sepolia!');
  } else {
    console.log('Contract verification is only supported on the Sepolia network.');
  }
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
