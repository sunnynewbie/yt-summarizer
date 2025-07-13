import _sequelize from "sequelize";
const DataTypes = _sequelize.DataTypes;
import _jobs from  "./jobs.js";
import _logs from  "./logs.js";
import _media from  "./media.js";
import _processingJobs from  "./processing_jobs.js";
import _refreshTokens from  "./refresh_tokens.js";
import _subscriptionPlan from  "./subscription_plan.js";
import _subscriptionsTbl from  "./subscriptions_tbl.js";
import _summaries from  "./summaries.js";
import _transcripts from  "./transcripts.js";
import _userSocialAccounts from  "./user_social_accounts.js";
import _userUsage from  "./user_usage.js";
import _users from  "./users.js";

export default function initModels(sequelize) {
  const jobs = _jobs.init(sequelize, DataTypes);
  const logs = _logs.init(sequelize, DataTypes);
  const media = _media.init(sequelize, DataTypes);
  const processingJobs = _processingJobs.init(sequelize, DataTypes);
  const refreshTokens = _refreshTokens.init(sequelize, DataTypes);
  const subscriptionPlan = _subscriptionPlan.init(sequelize, DataTypes);
  const subscriptionsTbl = _subscriptionsTbl.init(sequelize, DataTypes);
  const summaries = _summaries.init(sequelize, DataTypes);
  const transcripts = _transcripts.init(sequelize, DataTypes);
  const userSocialAccounts = _userSocialAccounts.init(sequelize, DataTypes);
  const userUsage = _userUsage.init(sequelize, DataTypes);
  const users = _users.init(sequelize, DataTypes);

  logs.belongsTo(media, { as: "medium", foreignKey: "media_id"});
  media.hasMany(logs, { as: "logs", foreignKey: "media_id"});
  processingJobs.belongsTo(media, { as: "medium", foreignKey: "media_id"});
  media.hasMany(processingJobs, { as: "processing_jobs", foreignKey: "media_id"});
  summaries.belongsTo(media, { as: "medium", foreignKey: "media_id"});
  media.hasMany(summaries, { as: "summaries", foreignKey: "media_id"});
  transcripts.belongsTo(media, { as: "medium", foreignKey: "media_id"});
  media.hasMany(transcripts, { as: "transcripts", foreignKey: "media_id"});
  subscriptionsTbl.belongsTo(subscriptionPlan, { as: "plan", foreignKey: "plan_id"});
  subscriptionPlan.hasMany(subscriptionsTbl, { as: "subscriptions_tbls", foreignKey: "plan_id"});
  refreshTokens.belongsTo(users, { as: "user", foreignKey: "user_id"});
  users.hasMany(refreshTokens, { as: "refresh_tokens", foreignKey: "user_id"});
  subscriptionsTbl.belongsTo(users, { as: "user", foreignKey: "user_id"});
  users.hasMany(subscriptionsTbl, { as: "subscriptions_tbls", foreignKey: "user_id"});
  userSocialAccounts.belongsTo(users, { as: "user", foreignKey: "user_id"});
  users.hasMany(userSocialAccounts, { as: "user_social_accounts", foreignKey: "user_id"});
  userUsage.belongsTo(users, { as: "user", foreignKey: "user_id"});
  users.hasMany(userUsage, { as: "user_usages", foreignKey: "user_id"});

  return {
    jobs,
    logs,
    media,
    processingJobs,
    refreshTokens,
    subscriptionPlan,
    subscriptionsTbl,
    summaries,
    transcripts,
    userSocialAccounts,
    userUsage,
    users,
  };
}
