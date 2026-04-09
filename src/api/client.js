import axios from "axios";

const api = axios.create({
  baseURL: "http://20.250.72.132/api",
});

api.interceptors.request.use((config) => {
  const token = window.localStorage.getItem("azfs_token");
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

export default api;
