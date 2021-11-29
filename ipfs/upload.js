const { create } = require("ipfs-http-client");

const ipfs = create("https://ipfs.infura.io:5001");

async function run() {
  const files = [{
    path: '/',
    content: JSON.stringify({
      name: "left",
      attributes: [
        {
          "trait_type": "Handspoint",
          "value": "100"
        }
      ],
      // if you want to upload your own IPFS image, you can do so here:
      // https://github.com/ChainShot/IPFS-Upload
      image: "https://gateway.ipfs.io/ipfs/QmTyR79YjBUVPwic6ZQbSCT2ZQJji6sL49SUGx96rV3ATJ",
      description: "Pointing Finger!"
    })
  }];

  const result = await ipfs.add(files);
  console.log(result);
}

run();
