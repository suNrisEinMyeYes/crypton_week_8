//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "./interfaces/IUniswapV2Router02.sol";
import "./interfaces/IUniswapV2Factory.sol";
import "@openzeppelin/contracts/utils/Counters.sol";



contract Adapter {

    uint amountA;
    uint amountB;
    uint liqTkns;
    uint[] amounts;


    //address internal constant UNISWAP_ROUTER_ADDRESS = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    //address internal constant UNISWAP_FACTORY_ADDRESS = 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;

    IUniswapV2Router02 public router;
    IUniswapV2Factory public factory;
    using Counters for Counters.Counter;
    Counters.Counter private _pairsIds;

    mapping(address => address) public pairs;
    mapping(uint256 => address) public idToPair;    

    constructor(address UNISWAP_ROUTER_ADDRESS, address UNISWAP_FACTORY_ADDRESS) { //
        router = IUniswapV2Router02(UNISWAP_ROUTER_ADDRESS);
        factory = IUniswapV2Factory(UNISWAP_FACTORY_ADDRESS);
    }

    function createPair(address tkn1, address tkn2) public{
        _pairsIds.increment();
        idToPair[_pairsIds.current()] = factory.createPair(tkn1, tkn2);
        
        pairs[tkn1] = tkn2;
        pairs[tkn2] = tkn1;
    }

    function provideLiq(address tkn1, address tkn2, uint amountADes, uint amountBDes, uint amountAMin, uint amountBMin) public{
        
       (amountA, amountB, liqTkns) = router.addLiquidity(tkn1, tkn2, amountADes, amountBDes, amountAMin, amountBMin, msg.sender, block.timestamp + 360);
       console.log(amountA, amountB, liqTkns);
    }

    function provideLiqEth(address tkn, uint amountDes, uint amountMin, uint ethMin) external payable{
        (amountA, amountB, liqTkns) = router.addLiquidityETH{value : msg.value}(tkn, amountDes, amountMin, ethMin, msg.sender, block.timestamp + 360);
        console.log(amountA, amountB, liqTkns);

    }

    function deleteLiq(address tkn1, address tkn2, uint liq, uint amountAMin, uint amountBMin) public{
        (amountA, amountB) = router.removeLiquidity(tkn1, tkn2, liq, amountAMin, amountBMin, msg.sender, block.timestamp + 360);
        console.log(amountA, amountB);
    }

    function deleteLiqEth(address tkn, uint liq, uint amountTknMin, uint amountEthMin) public{
        (amountA, amountB) = router.removeLiquidityETH(tkn, liq, amountTknMin, amountEthMin, msg.sender, block.timestamp + 360);
        console.log(amountA, amountB);
    }

    function swapExactAmountTo(uint amountIn, uint amountOutMin, address[] calldata path) public{
        //path = [tknIn .... tknOut]
        amounts = router.swapExactTokensForTokens(amountIn, amountOutMin, path, msg.sender, block.timestamp + 360);
        
    }

    function swapAmountToExactTkns(uint amountOut, uint amountInMax, address[] calldata path) public {
        //path = [tknIn .... tknOut]

        amounts = router.swapTokensForExactTokens(amountOut, amountInMax, path, msg.sender, block.timestamp + 360);
    }

    function swapExactEthToAmount(uint amountOutMin, address[] calldata path) payable public {
        //path = [WETH .... tknOut]

        amounts = router.swapExactETHForTokens{value: msg.value}(amountOutMin, path, msg.sender, block.timestamp + 360);
    }

    function swapTknsToExactEth(uint amountOut, uint amountInMax, address[] calldata path) public{
        //path = [tknIn .... WETH]

        amounts = router.swapTokensForExactETH(amountOut, amountInMax, path, msg.sender, block.timestamp + 360);
    }

    function swapExactTknsToAmountEth(uint amountIn, uint amountOutMin, address[] calldata path) public{
        //path = [tknIn .... WETH]

        amounts = router.swapExactTokensForETH(amountIn, amountOutMin, path, msg.sender, block.timestamp + 360);
    }

    function swapEthToExactAmount(uint amountOut, address[] calldata path) payable public{
        //path = [WETH .... tknOut]

        amounts = router.swapETHForExactTokens{value : msg.value}(amountOut, path, msg.sender, block.timestamp + 360);
    }

    function getAmounts() public view returns(uint[] memory){
        return amounts;
    }

    function getWeth() public view returns(address){
        return router.WETH();
    }

    function getPair(uint256 id)public view returns(address){
        return idToPair[id];
    }


    




   
}
