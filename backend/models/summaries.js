import _sequelize from 'sequelize';
const { Model, Sequelize } = _sequelize;

export default class summaries extends Model {
  static init(sequelize, DataTypes) {
  return super.init({
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    media_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'media',
        key: 'id'
      }
    },
    summary: {
      type: DataTypes.TEXT,
      allowNull: false
    },
    style: {
      type: DataTypes.STRING(50),
      allowNull: true,
      defaultValue: "paragraph"
    },
    prompt_used: {
      type: DataTypes.TEXT,
      allowNull: true
    },
    model_used: {
      type: DataTypes.STRING(20),
      allowNull: true,
      defaultValue: "gpt-4"
    },
    token_count: {
      type: DataTypes.INTEGER,
      allowNull: true
    },
    temperature: {
      type: DataTypes.DECIMAL,
      allowNull: true
    },
    top_p: {
      type: DataTypes.DECIMAL,
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'summaries',
    schema: 'public',
    timestamps: true,
    indexes: [
      {
        name: "idx_summary_media_id",
        fields: [
          { name: "media_id" },
        ]
      },
      {
        name: "summaries_pkey",
        unique: true,
        fields: [
          { name: "id" },
        ]
      },
    ]
  });
  }
}
