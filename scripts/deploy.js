


// imports
const { ethers, run, network } = require("hardhat")

// async main
async function main() {
  const EscrowFactory = await ethers.getContractFactory("Escrow")
  console.log("Deploying contract...")
  const escrow = await EscrowFactory.deploy()
  await escrow.deployed()
  console.log(`Deployed contract to: ${escrow.address}`)

  // Verify contract on Etherscan
  if (network.config.chainId === 11155111 && process.env.ETHERSCAN_API_KEY) {
    console.log("Waiting for block confirmations...")
    await escrow.deployTransaction.wait(6)
    await verify(escrow.address, [])
  }

  const currentValue = await escrow.retrieve()
  console.log(`Current Value is: ${currentValue}`)

  // Update the current value
  const transactionResponse = await escrow.store(7)
  await transactionResponse.wait(1)
  const updatedValue = await escrow.retrieve()
  console.log(`Updated Value is: ${updatedValue}`)
}

// async function verify(contractAddress, args) {
const verify = async (contractAddress, args) => {
  console.log("Verifying contract...")
  try {
    await run("verify:verify", {
      address: contractAddress,
      constructorArguments: args,
    })
  } catch (e) {
    if (e.message.toLowerCase().includes("already verified")) {
      console.log("Already Verified!")
    } else {
      console.log(e)
    }
  }
}

// main
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })
