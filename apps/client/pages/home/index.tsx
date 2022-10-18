import "./home.module.scss";
import type { NextPage } from "next";

interface HomeInterface {
  data: { [key: string]: any };
}

export const getServerSideProps = async () => {
  const { data } = await fetch(
    `${process.env.FLOWROME_CLIENT_BASE_URL}/home`
  ).then((res) => res.json());
  return {
    props: {
      data,
    },
  };
};

const Home: NextPage<HomeInterface> = ({data}) => {
  console.log(data)
  return <>HELLO WORLD</>;
};

export default Home;
