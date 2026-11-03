import { logger, schedules } from "@trigger.dev/sdk";

export const dailyCheckTask = schedules.task({
  id: "daily-check",
  cron: {
    pattern: "0 7 * * *",
    timezone: "Africa/Johannesburg",
  },
  run: async (payload) => {
    logger.log("Daily check running", { timestamp: payload.timestamp });
  },
});
