import _sequelize from 'sequelize';
const { Model, Sequelize } = _sequelize;

export default class userUsage extends Model {
  static init(sequelize, DataTypes) {
  return super.init({
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    user_id: {
      type: DataTypes.UUID,
      allowNull: true,
      references: {
        model: 'users',
        key: 'id'
      },
      unique: "user_usage_user_id_month_year_key"
    },
    month_year: {
      type: DataTypes.STRING(7),
      allowNull: false,
      unique: "user_usage_user_id_month_year_key"
    },
    videos_used: {
      type: DataTypes.INTEGER,
      allowNull: true,
      defaultValue: 0
    },
    minutes_used: {
      type: DataTypes.INTEGER,
      allowNull: true,
      defaultValue: 0
    },
    last_updated: {
      type: DataTypes.DATE,
      allowNull: true,
      defaultValue: Sequelize.Sequelize.literal('CURRENT_TIMESTAMP')
    }
  }, {
    sequelize,
    tableName: 'user_usage',
    schema: 'public',
    timestamps: false,
    indexes: [
      {
        name: "idx_user_month_usage",
        unique: true,
        fields: [
          { name: "user_id" },
          { name: "month_year" },
        ]
      },
      {
        name: "user_usage_pkey",
        unique: true,
        fields: [
          { name: "id" },
        ]
      },
      {
        name: "user_usage_user_id_month_year_key",
        unique: true,
        fields: [
          { name: "user_id" },
          { name: "month_year" },
        ]
      },
    ]
  });
  }
}
