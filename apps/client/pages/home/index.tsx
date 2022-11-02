import "./home.module.scss";
import type { NextPageWithLayout } from "@app";
import BasePageLayout from "@layouts/BasePage";
import { ReactElement } from "react";
import { DocReadme } from "@floact/uilib";

interface HomeInterface {
  data: { [key: string]: any };
}

export const getServerSideProps = async () => {
  try {
    const { data } = await fetch(
      `${process.env.FLOACT_CLIENT_BASE_URL}/home`
    ).then((res) => res.json());
    return {
      props: {
        data,
      },
    };
  } catch (err) {
    return {
      props: {
        data: null,
      },
    };
  }
};

const Home: NextPageWithLayout<HomeInterface> = ({ data }) => {
  return (
    <>
      <DocReadme apiTestString={data?.helloWorld}></DocReadme>
    </>
  );
};

Home.getLayout = function getLayout(page: ReactElement) {
  return <BasePageLayout>{page}</BasePageLayout>;
};

export default Home;
