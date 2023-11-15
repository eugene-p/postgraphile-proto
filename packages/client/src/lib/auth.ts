let authToken:string = '';

export const getAuthHeader = ():string => `Bearer ${authToken}`;
export const setAuthToken = (token: string):string => (authToken = token);
export const getAuthToken = ():string => authToken;