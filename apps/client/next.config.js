/** @type {import('next').NextConfig} */

require("dotenv").config({
  path: `../../envs/.env.${process.env.ENV || "production"}`,
});

const nextConfig = {
  output: "standalone",
  reactStrictMode: true,
  swcMinify: true,
  async redirects() {
    return [
      {
        source: "/",
        destination: "/home",
        permanent: true,
      },
    ];
  }
};

module.exports = nextConfig;
