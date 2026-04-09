import axios from "axios";

const api = axios.create({
  baseURL: "https://az-fileshare-backend-hug6ake3a8amdyc7.switzerlandnorth-01.azurewebsites.net",
});

api.interceptors.request.use((config) => {
  const token = window.localStorage.getItem("azfs_token");
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

export default api;
