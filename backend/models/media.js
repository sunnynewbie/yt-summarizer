import _sequelize from 'sequelize';
const { Model, Sequelize } = _sequelize;

export default class media extends Model {
  static init(sequelize, DataTypes) {
  return super.init({
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    source_url: {
      type: DataTypes.TEXT,
      allowNull: false
    },
    title: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    type: {
      type: DataTypes.STRING(50),
      allowNull: true,
      defaultValue: "youtube"
    },
    audio_format: {
      type: DataTypes.STRING(10),
      allowNull: true
    },
    duration_seconds: {
      type: DataTypes.INTEGER,
      allowNull: true
    },
    status: {
      type: DataTypes.STRING(20),
      allowNull: false,
      defaultValue: "processing"
    },
    failure_reason: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    audio_path: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    processed_at: {
      type: DataTypes.DATE,
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'media',
    schema: 'public',
    timestamps: true,
    indexes: [
      {
        name: "idx_media_status",
        fields: [
          { name: "status" },
        ]
      },
      {
        name: "media_pkey",
        unique: true,
        fields: [
          { name: "id" },
        ]
      },
    ]
  });
  }
}
