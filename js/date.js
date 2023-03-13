const currentDate = new Date();
const formattedDate = currentDate.toLocaleString('en-US', {
  weekday: 'short',
  day: 'numeric',
  hour: 'numeric',
  minute: 'numeric',
  hour12: false
});

console.log(formattedDate);