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

const convertMainToUah = async function() {
	let mainQty = 1;
	console.log(process.argv.length); return;
	if (process.argv.length > 2) {
		mainQty = parseFloat(process.argv[2]);
	}
	const usdToUah = 40;
	let price = await getPrice();
	let priceUah = price*usdToUah*mainQty;
	console.log(priceUah);
}

console.log(process.argv.length); return;
// convertMainToUah();