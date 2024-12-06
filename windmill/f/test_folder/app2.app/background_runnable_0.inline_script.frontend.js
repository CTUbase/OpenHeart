// read outputs and ctx
console.log(ctx.email)

// access a global state store
if (!state.foo) { state.foo = 0 }
state.foo += 1

// for reactivity to work, you need to assign a value and not modify it in place
// e.g: state.foo.push(1) will not work but 'state.foo = [...state.foo, 1]' will.
// you may also just reassign as next statement 'state.foo = state.foo'

// you can also navigate (goto), recompute a script (recompute), or set a tab (setTab)
// Inputs and display components support settings their value directly
// setValue('a', "Bar") 
// Tables support setting their selected index (setSelectedIndex)
// all helpers can be found at https://www.windmill.dev/docs/apps/app-runnable-panel#frontend-scripts-helpers
const currentUrl = window.location.href;
const parsedUrl = new URL(currentUrl);

// Use URLSearchParams to get the query parameter
const paramValue = parsedUrl.searchParams.get('param');

return paramValue