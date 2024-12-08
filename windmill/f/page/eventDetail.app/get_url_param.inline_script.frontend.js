const currentUrl = window.location.href;
const parsedUrl = new URL(currentUrl);

// Use URLSearchParams to get the query parameter
const userParam = parsedUrl.searchParams.get('user');
const eventParam = parsedUrl.searchParams.get('event');

// Create a JSON object and return it
const resultJson = { 
  id: userParam ? Number(userParam) : null ,
  event_id: eventParam ? Number(eventParam): null}; // Convert to number if needed, or set `null` if `user` is not present.

return resultJson;
