const currentUrl = window.location.href;
const parsedUrl = new URL(currentUrl);

// Use URLSearchParams to get the query parameter
const id_user = parsedUrl.searchParams.get('id_user');

return id_user