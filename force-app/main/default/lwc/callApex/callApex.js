const callApex = async (action, params) => {
    try {
        const result = await action(params);
        return [result || {}, null];
    } catch (ex) {
        return [null, ex?.body?.message || ''];
    }
}

export { callApex };