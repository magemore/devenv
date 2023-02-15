//Using Axios
const axios = require('axios');

axios.get('https://pro-api.coinmarketcap.com/v1/tools/price-conversion?amount=1&symbol=MAIN&convert=USD', {
  headers: {
    'X-CMC_PRO_API_KEY': '0b73c248-a656-4ef8-86b4-453ff1b4bcfd',
  },
})
  .then(function (response) {
    // get BNB price in BUSD
    console.log(response.data.data.quote.USD.price);
    // const bnbInBusd = response.data.data.quotes.BUSD.price; 
    // console.log(bnbInBusd);
  })
  .catch(function (error) {
    // handle error
    console.log(error);
  })
  .finally(function () {
    // always executed
  });