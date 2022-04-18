import { getContractFactory } from "@nomiclabs/hardhat-ethers/types";
import { expect } from "chai";
import { Contract, Signer } from "ethers";
import { parseEther } from "ethers/lib/utils";
import { ethers } from "hardhat";
import {abi as abi_factory, bytecode as bc_factory} from "@uniswap/v2-core/build/UniswapV2Factory.json"
import {abi as abi_router, bytecode as bc_router} from "@uniswap/v2-periphery/build/UniswapV2Router02.json"
import {abi as abi_weth, bytecode as bc_weth} from "canonical-weth/build/contracts/WETH9.json"


describe("Token contract", function () {

  let acdm;
  let pop;
  let tst;
  let adapter;
  let factory;
  let router;
  let weth;

  let acdmContract: Contract;
  let popContract: Contract;
  let tstContract: Contract;
  let adapterContract: Contract;
  let factoryContract: Contract;
  let routerContract: Contract;
  let wethContract : Contract;



  let adapterOwner: Signer;
  let tstOwner: Signer;
  let popOwner: Signer;
  let acdmOwner: Signer;
  let factoryOwner : Signer;
  let routerOwner : Signer;

  let acdmUser: Signer;
  let popUser: Signer;
  let tstUser: Signer;
  let adapterUser: Signer;
  let factoryUser : Signer;
  let routerUser : Signer;


 


  beforeEach(async function () {



    acdm = await ethers.getContractFactory("Acdm");
    [acdmOwner, acdmUser] = await ethers.getSigners();
    acdmContract = await acdm.deploy();
    pop = await ethers.getContractFactory("Pop");
    [popOwner, popUser] = await ethers.getSigners();
    popContract = await pop.deploy();
    tst = await ethers.getContractFactory("Tst");
    [tstOwner, tstUser] = await ethers.getSigners();
    tstContract = await tst.deploy();

    weth = new ethers.ContractFactory(abi_weth, bc_weth, tstUser);
    wethContract = await weth.deploy();

    factory = new ethers.ContractFactory(abi_factory, bc_factory, tstUser);
    factoryContract = await factory.deploy(acdmContract.address)

    router = new ethers.ContractFactory(abi_router, bc_router, tstUser);
    routerContract = await router.deploy(factoryContract.address, wethContract.address)
    

    adapter = await ethers.getContractFactory("Adapter");
    [adapterOwner, adapterUser] = await ethers.getSigners();
    adapterContract = await adapter.deploy(routerContract.address, factoryContract.address);

    




    
  


  });

  describe("deposit tkns", function () {

    it("upload some tokens", async function () {

      await adapterContract.connect(tstUser).createPair(acdmContract.address, popContract.address)
      console.log(await adapterContract.getPair(1))
      await acdmContract.connect(acdmOwner).mint(tstUser.getAddress(), parseEther("50"))
      await acdmContract.connect(tstUser).transfer(await adapterContract.getPair(1), parseEther("1"))
      await acdmContract.connect(tstUser).approve(await adapterContract.getPair(1), parseEther("50"))

      await popContract.connect(popOwner).mint(tstUser.getAddress(), parseEther("50"))
      await popContract.connect(tstUser).transfer(await adapterContract.getPair(1), parseEther("1"))
      await popContract.connect(tstUser).approve(await adapterContract.getPair(1), parseEther("50"))



      await adapterContract.connect(tstUser).provideLiq(acdmContract.address, popContract.address, parseEther("5"), parseEther("5"), parseEther("0.01"), parseEther("0.01"))

    });
    
  });


});