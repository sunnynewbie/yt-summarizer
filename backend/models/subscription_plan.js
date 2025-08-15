import _sequelize from 'sequelize';
const { Model, Sequelize } = _sequelize;

export default class subscriptionPlan extends Model {
  static init(sequelize, DataTypes) {
    return super.init({
      id: {
        autoIncrement: true,
        type: DataTypes.INTEGER,
        allowNull: false,
        primaryKey: true
      },
      plan_name: {
        type: DataTypes.STRING(50),
        allowNull: false,
        unique: "subscription_plan_plan_name_key"
      },
      plan_content: {
        type: DataTypes.TEXT,
      },
      video_limit: {
        type: DataTypes.INTEGER,
        allowNull: false
      },
      minute_limit: {
        type: DataTypes.INTEGER,
        allowNull: false
      },
      price: {
        type: DataTypes.DECIMAL,
        allowNull: false
      },
      is_active: {
        type: DataTypes.BOOLEAN,
        allowNull: true,
        defaultValue: true
      }
    }, {
      sequelize,
      tableName: 'subscription_plan',
      schema: 'public',
      timestamps: false,
      indexes: [
        {
          name: "subscription_plan_pkey",
          unique: true,
          fields: [
            { name: "id" },
          ]
        },
        {
          name: "subscription_plan_plan_name_key",
          unique: true,
          fields: [
            { name: "plan_name" },
          ]
        },
      ]
    });
  }
}
