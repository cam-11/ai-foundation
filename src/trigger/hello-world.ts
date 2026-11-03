import { logger, task } from "@trigger.dev/sdk";

type HelloWorldPayload = {
  name: string;
};

export const helloWorldTask = task({
  id: "hello-world",
  run: async (payload: HelloWorldPayload) => {
    const now = new Date();

    logger.log(`Hello, ${payload.name}!`);

    return {
      greeting: `Hello, ${payload.name}!`,
      currentTime: now.toISOString(),
    };
  },
});
