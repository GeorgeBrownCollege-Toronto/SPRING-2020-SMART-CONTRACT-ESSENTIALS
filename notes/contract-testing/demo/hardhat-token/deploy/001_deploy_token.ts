import {HardhatRuntimeEnvironment} from 'hardhat/types'
import {DeployFunction} from 'hardhat-deploy/types'

const func:DeployFunction = async (hre:HardhatRuntimeEnvironment) => {
    const {deployments, getNamedAccounts} = hre;
    const {deploy} = deployments; 

    const {deployer, tokenOwner} = await getNamedAccounts();

    await deploy('Token',{
        log:true,
        from:deployer,
        args:[tokenOwner]
    })
}
export default func;
func.tags = ['Token'];