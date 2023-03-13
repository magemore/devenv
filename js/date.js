const currentDate = new Date();
const options = {weekday: 'short', month: 'short', day: 'numeric', hour: 'numeric', minute: 'numeric', hour12: false};
const formattedDate = currentDate.toLocaleString('en-US', options);

console.log(formattedDate);