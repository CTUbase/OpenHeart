const currentUrl = window.location.href;
const parsedUrl = new URL(currentUrl);

// Use URLSearchParams to get the query parameter
const userParam = parsedUrl.searchParams.get('user');

// Create a JSON object and return it
const resultJson = { id: userParam ? Number(userParam) : null }; // Convert to number if needed, or set `null` if `user` is not present.

return resultJson;
