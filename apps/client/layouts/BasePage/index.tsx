import Head from "next/head";
import { useEffect, useState } from "react";

type BasePageLayoutType = {
  children: React.ReactNode;
};

const BasePageLayout = ({ children }: BasePageLayoutType) => {
  const [themeColor, setThemeColor] = useState("#000000");

  useEffect(() => {
    setThemeColor(
      getComputedStyle(document.documentElement).getPropertyValue(
        "--flowrome-theme-color"
      )
    );
  }, []);

  return (
    <>
      <Head>
        <title>{process.env.FLOWROME_CLIENT_NAME}</title>
        <meta
          name="theme-color"
          media="(prefers-color-scheme: light)"
          key="light-theme"
          content={themeColor}
        />
        <meta
          name="theme-color"
          media="(prefers-color-scheme: dark)"
          key="dark-theme"
          content={themeColor}
        />
      </Head>
      <>{children}</>
    </>
  );
};

export default BasePageLayout;
