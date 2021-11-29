const friends = [
    "0x92bC0dA159D495d3Ca7081544841EC6BD415eB9E",
    "0xdB52bd8213E8eedc3b9F3e3b2087659A8743b344",
    "0xe15A4F5eA424B540e6B0558105f88c5D39735374",
];
const existingContractAddr = "0xd2C43D26daE4d73F3b8afA131915E5937B0B8bdC";

async function main() {
  const nft = await hre.ethers.getContractAt("MimTestnet", existingContractAddr);

  const signer0 = await ethers.provider.getSigner(0);
  const nonce = await signer0.getTransactionCount();
  for(let i = 0; i < friends.length; i++) {
    const tokenURI = "https://gateway.ipfs.io/ipfs/QmWA2s5nNjEhMNb3VbzYgWWHpdTgZ4iHo4krGMFmxTFpA4";
    await nft.awardItem(friends[i], tokenURI,  {
      nonce: nonce + i
    });
  }

  console.log("Minting is complete!");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
