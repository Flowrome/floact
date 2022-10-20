import "./home.module.scss";
import type { NextPageWithLayout } from "@app";
import BasePageLayout from "@layouts/BasePage";
import { ReactElement } from "react";

interface HomeInterface {
  data: { [key: string]: any };
}

export const getServerSideProps = async () => {
  const { data } = await fetch(
    `${process.env.FLOACT_CLIENT_BASE_URL}/home`
  ).then((res) => res.json());
  return {
    props: {
      data,
    },
  };
};

const Home: NextPageWithLayout<HomeInterface> = () => {
  return (
    <>
      <>HELLO WORLD</>
    </>
  );
};

Home.getLayout = function getLayout(page: ReactElement) {
  return <BasePageLayout>{page}</BasePageLayout>;
};

export default Home;
