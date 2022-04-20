// SPDX-License-Identifier: MIT
// Sources flattened with hardhat v2.9.3 https://hardhat.org

// File contracts/interfaces/IUniswapV2Router01.sol

pragma solidity >=0.6.2;

interface IUniswapV2Router01 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}


// File contracts/interfaces/IUniswapV2Router02.sol

pragma solidity >=0.6.2;

interface IUniswapV2Router02 is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}


// File contracts/interfaces/IUniswapV2Factory.sol

pragma solidity >=0.5.0;

interface IUniswapV2Factory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function allPairs(uint) external view returns (address pair);
    function allPairsLength() external view returns (uint);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;
    function setFeeToSetter(address) external;
}


// File @openzeppelin/contracts/utils/Counters.sol@v4.5.0


// OpenZeppelin Contracts v4.4.1 (utils/Counters.sol)

pragma solidity ^0.8.0;

/**
 * @title Counters
 * @author Matt Condon (@shrugs)
 * @dev Provides counters that can only be incremented, decremented or reset. This can be used e.g. to track the number
 * of elements in a mapping, issuing ERC721 ids, or counting request ids.
 *
 * Include with `using Counters for Counters.Counter;`
 */
library Counters {
    struct Counter {
        // This variable should never be directly accessed by users of the library: interactions must be restricted to
        // the library's function. As of Solidity v0.5.2, this cannot be enforced, though there is a proposal to add
        // this feature: see https://github.com/ethereum/solidity/issues/4637
        uint256 _value; // default: 0
    }

    function current(Counter storage counter) internal view returns (uint256) {
        return counter._value;
    }

    function increment(Counter storage counter) internal {
        unchecked {
            counter._value += 1;
        }
    }

    function decrement(Counter storage counter) internal {
        uint256 value = counter._value;
        require(value > 0, "Counter: decrement overflow");
        unchecked {
            counter._value = value - 1;
        }
    }

    function reset(Counter storage counter) internal {
        counter._value = 0;
    }
}


// File contracts/Adapter.sol

pragma solidity ^0.8.0;



contract Adapter {

    uint liqTkns;


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
        
       router.addLiquidity(tkn1, tkn2, amountADes, amountBDes, amountAMin, amountBMin, msg.sender, block.timestamp + 360);
    }

    function provideLiqEth(address tkn, uint amountDes, uint amountMin, uint ethMin) external payable{
        router.addLiquidityETH{value : msg.value}(tkn, amountDes, amountMin, ethMin, msg.sender, block.timestamp + 360);

    }

    function deleteLiq(address tkn1, address tkn2, uint liq, uint amountAMin, uint amountBMin) public{
        router.removeLiquidity(tkn1, tkn2, liq, amountAMin, amountBMin, msg.sender, block.timestamp + 360);
        
    }

    function deleteLiqEth(address tkn, uint liq, uint amountTknMin, uint amountEthMin) public{
        router.removeLiquidityETH(tkn, liq, amountTknMin, amountEthMin, msg.sender, block.timestamp + 360);
        
    }

    function swapExactAmountTo(uint amountIn, uint amountOutMin, address[] calldata path) public{
        //path = [tknIn .... tknOut]
        router.swapExactTokensForTokens(amountIn, amountOutMin, path, msg.sender, block.timestamp + 360);
        
    }

    function swapAmountToExactTkns(uint amountOut, uint amountInMax, address[] calldata path) public {
        //path = [tknIn .... tknOut]

        router.swapTokensForExactTokens(amountOut, amountInMax, path, msg.sender, block.timestamp + 360);
    }

    function swapExactEthToAmount(uint amountOutMin, address[] calldata path) payable public {
        //path = [WETH .... tknOut]

        router.swapExactETHForTokens{value: msg.value}(amountOutMin, path, msg.sender, block.timestamp + 360);
    }

    function swapTknsToExactEth(uint amountOut, uint amountInMax, address[] calldata path) public{
        //path = [tknIn .... WETH]

        router.swapTokensForExactETH(amountOut, amountInMax, path, msg.sender, block.timestamp + 360);
    }

    function swapExactTknsToAmountEth(uint amountIn, uint amountOutMin, address[] calldata path) public{
        //path = [tknIn .... WETH]

        router.swapExactTokensForETH(amountIn, amountOutMin, path, msg.sender, block.timestamp + 360);
    }

    function swapEthToExactAmount(uint amountOut, address[] calldata path) payable public{
        //path = [WETH .... tknOut]

        router.swapETHForExactTokens{value : msg.value}(amountOut, path, msg.sender, block.timestamp + 360);
    }

    function getWeth() public view returns(address){
        return router.WETH();
    }

    function getPair(uint256 id)public view returns(address){
        return idToPair[id];
    }


    




   
}


// File contracts/flattened.sol
