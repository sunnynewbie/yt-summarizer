import _sequelize from 'sequelize';
const { Model, Sequelize } = _sequelize;

export default class jobs extends Model {
  static init(sequelize, DataTypes) {
    return super.init({
      id: {
        type: DataTypes.UUID,
        allowNull: false,
        defaultValue: DataTypes.UUIDV4,
        primaryKey: true
      },
      video_url: {
        type: DataTypes.TEXT,
        allowNull: false
      },
      video_title: {
        type: DataTypes.TEXT,
        allowNull: true
      },
      video_duration_seconds: {
        type: DataTypes.INTEGER,
        allowNull: true
      },
      status: {
        type: DataTypes.TEXT,
        allowNull: false,
        defaultValue: "queued"
      },
      progress: {
        type: DataTypes.TEXT,
        allowNull: true
      },
      transcript: {
        type: DataTypes.TEXT,
        allowNull: true
      },
      summary: {
        type: DataTypes.TEXT,
        allowNull: true
      },
      transcript_url: {
        type: DataTypes.TEXT,
        allowNull: true
      },
      summary_url: {
        type: DataTypes.TEXT,
        allowNull: true
      },
      error_message: {
        type: DataTypes.TEXT,
        allowNull: true
      }
    }, {
      sequelize,
      tableName: 'jobs',
      schema: 'public',
      timestamps: false,
      indexes: [
        {
          name: "jobs_pkey",
          unique: true,
          fields: [
            { name: "id" },
          ]
        },
      ]
    });
  }
}
