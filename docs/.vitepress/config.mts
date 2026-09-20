import { defineConfig } from "vitepress";

export default defineConfig({
  title: "Qintrix Docs",
  description: "Qintrix Documentation",
  mpa: true,
  appearance: false,
  head: [
    ["link", { rel: "icon", type: "image/svg+xml", href: "/images/logo.png" }],
    ["link", { rel: "icon", type: "image/png", href: "/images/logo.png" }],
    [
      "link",
      {
        rel: "preconnect",
        href: "https://fonts.googleapis.com",
      },
    ],
    [
      "link",
      {
        rel: "preconnect",
        href: "https://fonts.gstatic.com",
      },
    ],
    [
      "link",
      {
        rel: "stylesheet",
        href: "https://fonts.googleapis.com/css2?family=Cairo:wght@200..1000&display=swap",
      },
    ],
  ],
  themeConfig: {
    logo: { src: "/images/logo.png" },
    logoLink: process.env.NODE_ENV === "production" ? "../index.html" : "/",
    // search: {
    //   provider: "local",
    // },
    nav: [
      // {
      //   text: "Bay Qintrix",
      //   link: "https://codecanyon.net/item/forkiva-restaurant-pos-management-system-laravel-vuejs/59812356",
      // },
      // {
      //   text: "View Demo",
      //   link: "https://qintrix.tenvoro.app",
      // },
      // {
      //   text: "Download",
      //   link: "https://qintrix.tenvoro.app/#download",
      // },
    ],
    sidebar: [
      {
        text: "Guide",
        items: [
          {
            text: "Introduction",
            link: "/guide/introduction",
          },
        ],
      },
      {
        text: "Installation",
        items: [
          {
            text: "Requirements",
            link: "/guide/requirements",
          },
          {
            text: "Installing Qintrix",
            link: "/guide/installing-qintrix",
          },
        ],
      },
      {
        text: "Application Pages",
        items: [
          {
            text: "Overview",
            link: "/guide/home",
          },
          {
            text: "Dashboard",
            link: "/guide/dashboard",
          },
          {
            text: "Server",
            link: "/guide/server",
          },
          {
            text: "Printers",
            link: "/guide/printers",
          },
          {
            text: "Jobs",
            link: "/guide/jobs",
          },
          {
            text: "Apps",
            link: "/guide/apps",
          },
          {
            text: "Logs",
            link: "/guide/logs",
          },
          {
            text: "Settings",
            link: "/guide/settings",
          },
          {
            text: "About App",
            link: "/guide/about",
          },
        ],
      },
      {
        text: "SDK",
        items: [
          {
            text: "Web SDK",
            link: "/guide/web-sdk",
          },
        ],
      },
    ],
    footer: {
      message: "Tenvoro",
      copyright: "Copyright © Tenvoro",
    },
  },
});
