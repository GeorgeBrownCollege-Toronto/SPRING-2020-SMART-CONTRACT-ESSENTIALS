async function main() {
  const AirdropNFT = await hre.ethers.getContractFactory("AirdropNFT");
  const nft = await AirdropNFT.deploy();

  await nft.deployed();

  console.log("AirdropNFT deployed to:", nft.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
