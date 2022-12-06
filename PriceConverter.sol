// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

// this is a link to npm package from chainlink oracle
// this package is needed to get the latest price feed of the market
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice() internal view returns(uint256) {
        // need to create an object with the address of reference contract, for fetching the price feed
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        // the "latestRoundData()" function returns lots of thing but we are only interested in the price right now
        (
            ,
            int256 price,
            ,
            ,

        ) = priceFeed.latestRoundData();

        // price returns a value like this => 128133970178
        // this value is actually 1281.3970178, but we can't see the decimal symbol
        // because solidity doesn't work very well with decimal values.
        // msg.value returns a number with 18 decimal places. So for doing math,
        // we need to have both the values with the exact number of digits after the decimal
        // that is why, multiplying the price with 1e10, so that it can now have 18 decimal places
        return uint256(price * 1e10);
    }
 
    // this function is for calculating the donated amount in terms of USD
    function getConversionRate(uint256 ethAmount) internal view returns(uint256) {
        // eth donated times price per eth will give us the total donated value
        // But, as we are doing (ethAmount * 10^18) * (rate * 10^18),
        // the result have 36 digits after decimal point.
        // But we are doing calculation with 18 decimal digits.
        // So, to convert it back to 18 decimal places, we are dividing the product with 10^18 
        return (ethAmount * getPrice()) / 1e18;
    }
}