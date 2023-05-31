###web3escrow
#Introduction

The web3escrow project aims to provide a secure and automated escrow system for peer-to-peer marketplaces using smart contracts on the Ethereum blockchain. In traditional transactions, an escrow is a financial arrangement where a trusted third party holds funds or assets on behalf of the transacting parties until the transaction is completed.


#Why do we need escrows?

Escrows play a crucial role in mitigating risks and building trust in various transactions, particularly in online marketplaces. They ensure that buyers and sellers can safely conduct transactions by minimizing the potential for fraud, non-payment, or misrepresentation.


#Problems with real-world escrows

While real-world escrows offer some level of security, they are not without their challenges. These challenges include:

    Cost: Real-world escrow services often come with significant fees, making them expensive for small transactions.
    Centralization: Traditional escrow services require trust in a centralized third party, which can be prone to manipulation or failure.
    Delays: The manual nature of real-world escrows can lead to delays in the release of funds or assets, causing inconvenience for the parties involved.
    Limited accessibility: Some geographical regions lack reliable escrow services, limiting participation in global marketplaces.

#Problem web3 escrow solves

The web3escrow project leverages the power of blockchain technology and smart contracts to address the limitations of traditional escrow services. By using decentralized and transparent escrow contracts on the Ethereum blockchain, it offers the following benefits:

    Security: The use of smart contracts ensures that funds or assets are held securely and can only be released according to predefined conditions agreed upon by the transacting parties.
    Automation: Smart contracts enable automated execution of escrow transactions, eliminating the need for manual intervention and reducing delays.
    Trustlessness: The reliance on smart contracts removes the need for trust in a centralized third party, providing a trustless environment for transacting parties.
    Global Accessibility: Web3 escrow contracts are accessible to anyone with an internet connection, enabling participation in global marketplaces without geographical limitations.

#Our approach

The web3escrow project implements a smart contract-based escrow system using Solidity and the Ethereum blockchain. The escrow contract holds the funds or assets in a secure manner and includes features such as dispute resolution and multi-signature transactions.
![contract diagram](/img/img.svg)

[Deployed Contract on Sepolia](https://sepolia.etherscan.io/address/0xC9baB9A161201501FFd7D4cE96e8206832CD08BF#code)

To run the code, you can either copy the contract and use Remix IDE. Or you can clone the repository using 
```

```
Go into the directory
```
cd 
```
Install the dependencies running 
```
yarn
```
You can also add hardhat with 
```
yarn add --dev hardhat
```
Install the rest of the dependencies if necessary.

Compile the files with 
```
yarn hardhat compile
```

Deploy the files on hardhat node
```
yarn hardhat run scripts/deploy.js
```
Deploy on sepolia and verify. the verification link would also be sent. Example:- https://sepolia.etherscan.io/address/0xC9baB9A161201501FFd7D4cE96e8206832CD08BF#code
```
yarn hardhat run scripts/deploy.js --network sepolia
```

#Future plans for the project include:

    Testing: Comprehensive testing will be conducted to ensure the reliability and security of the escrow system.
    UI: A user interface will be developed to provide a user-friendly experience for interacting with the escrow contracts.
    Gas Optimization: The contract code will be further optimized to reduce gas costs and improve efficiency.

#Conclusion

The web3escrow project aims to revolutionize the way escrows are conducted in peer-to-peer marketplaces by leveraging the power of blockchain technology. By providing a secure, automated, and trustless escrow system, web3escrow offers a viable solution to the limitations of traditional escrow services. With future developments, we strive to enhance the usability and efficiency of the escrow system, ultimately benefiting users in their online transactions.