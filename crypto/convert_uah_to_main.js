// This code is used to convert UAH to MAIN, using the CoinMarketCap API. It uses the axios library to make an API call to the CoinMarketCap API. It then uses the response data to calculate the price of MAIN and then logs the result to the console.

const axios = require('axios');

const getPrice = async function() {
	let result = null;
  try {
    // use axios to make API call
    const response = await axios.get('https://pro-api.coinmarketcap.com/v1/tools/price-conversion?amount=1&symbol=MAIN&convert=USD', {
      headers: {
        'X-CMC_PRO_API_KEY': '0b73c248-a656-4ef8-86b4-453ff1b4bcfd',
      },
    });
    result = response.data.data.quote.USD.price;
		// console.log(result);
  } catch (err) {
    console.log(err);
  }
	return result;
};

const convertUahToMain = async function() {
	let uahQty = 1;
	if (process.argv.length > 2) {
		uahQty = parseFloat(process.argv[2]);
	}
	const usdToUah = 39;
	let price = await getPrice();
	let priceMain = uahQty / (price*usdToUah);
	priceMain = priceMain.toFixed(2);
	console.log(priceMain);
}

convertUahToMain();
