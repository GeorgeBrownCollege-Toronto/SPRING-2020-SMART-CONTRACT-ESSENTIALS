## Class Activity : ERC20 Token Payment
* Use account 1 to deploy <a target="_blank" href="https://github.com/GeorgeBrownCollege-Toronto/Smart-Contract-Essentials/blob/master/notes/tokens/ERC20/demo/ERC20Demo.sol">TokenFaucet</a> contract

* Use account 1 to deploy <a target="_blank" href="https://github.com/GeorgeBrownCollege-Toronto/Smart-Contract-Essentials/blob/master/notes/tokens/ERC20/demo/WETH.sol">WETH</a> contract.
* Use account 1 to mint token</li>
* Use account 2 to deploy the TokenSale contract using account 1 as the wallet. <a target="_blank" href="https://github.com/GeorgeBrownCollege-Toronto/Smart-Contract-Essentials/blob/master/notes/tokens/ERC20/demo/ERC20Demo.sol">TokenSale</a>
* Use account 1 to approve tokenSale to transfer tokens
* Use account 3 to purchase WETH token
* Use account 3 to approve tokenSale contract to spend <b>WETH</b>
* Use account 3 to call `tokenSale.buyToken(1000)`