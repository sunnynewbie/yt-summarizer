import _sequelize from "sequelize";
const DataTypes = _sequelize.DataTypes;
import _logs from  "./logs.js";
import _media from  "./media.js";
import _processingJobs from  "./processing_jobs.js";
import _summaries from  "./summaries.js";
import _transcripts from  "./transcripts.js";

export default function initModels(sequelize) {
  const logs = _logs.init(sequelize, DataTypes);
  const media = _media.init(sequelize, DataTypes);
  const processingJobs = _processingJobs.init(sequelize, DataTypes);
  const summaries = _summaries.init(sequelize, DataTypes);
  const transcripts = _transcripts.init(sequelize, DataTypes);

  logs.belongsTo(media, { as: "medium", foreignKey: "media_id"});
  media.hasMany(logs, { as: "logs", foreignKey: "media_id"});
  processingJobs.belongsTo(media, { as: "medium", foreignKey: "media_id"});
  media.hasMany(processingJobs, { as: "processing_jobs", foreignKey: "media_id"});
  summaries.belongsTo(media, { as: "medium", foreignKey: "media_id"});
  media.hasMany(summaries, { as: "summaries", foreignKey: "media_id"});
  transcripts.belongsTo(media, { as: "medium", foreignKey: "media_id"});
  media.hasMany(transcripts, { as: "transcripts", foreignKey: "media_id"});

  return {
    logs,
    media,
    processingJobs,
    summaries,
    transcripts,
  };
}
