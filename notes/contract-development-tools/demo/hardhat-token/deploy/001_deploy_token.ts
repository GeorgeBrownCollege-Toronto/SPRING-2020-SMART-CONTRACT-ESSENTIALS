import {HardhatRuntimeEnvironment} from 'hardhat/types'
import {DeployFunction} from 'hardhat-deploy/types'

const func:DeployFunction = async (hre:HardhatRuntimeEnvironment) => {
    const {deployments, getUnnamedAccounts} = hre;
    const {deploy} = deployments; 

    const accounts = await getUnnamedAccounts();

    await deploy('Token',{
        log:true,
        from:accounts[0]
    })
}
export default func;
func.tags = ['Token'];