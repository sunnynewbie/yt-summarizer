import _sequelize from 'sequelize';
const { Model } = _sequelize;

export default class auditLogs extends Model {
  static init(sequelize, DataTypes) {
    return super.init({
      id: {
        type: DataTypes.UUID,
        allowNull: false,
        defaultValue: DataTypes.UUIDV4,
        primaryKey: true
      },
      request_id: {
        type: DataTypes.UUID,
        allowNull: true
      },
      actor_user_id: {
        type: DataTypes.UUID,
        allowNull: true,
        references: {
          model: 'users',
          key: 'id'
        }
      },
      actor_role: {
        type: DataTypes.TEXT,
        allowNull: true
      },
      action: {
        type: DataTypes.TEXT,
        allowNull: false
      },
      feature_area: {
        type: DataTypes.TEXT,
        allowNull: true
      },
      resource_type: {
        type: DataTypes.TEXT,
        allowNull: true
      },
      resource_id: {
        type: DataTypes.TEXT,
        allowNull: true
      },
      http_method: {
        type: DataTypes.TEXT,
        allowNull: false
      },
      route_path: {
        type: DataTypes.TEXT,
        allowNull: true
      },
      status_code: {
        type: DataTypes.INTEGER,
        allowNull: false
      },
      outcome: {
        type: DataTypes.TEXT,
        allowNull: false
      },
      ip_address: {
        type: DataTypes.TEXT,
        allowNull: true
      },
      user_agent: {
        type: DataTypes.TEXT,
        allowNull: true
      },
      client_origin: {
        type: DataTypes.TEXT,
        allowNull: true
      },
      duration_ms: {
        type: DataTypes.INTEGER,
        allowNull: true
      },
      metadata: {
        type: DataTypes.JSONB,
        allowNull: false,
        defaultValue: {}
      },
      created_at: {
        type: DataTypes.DATE,
        allowNull: false,
        defaultValue: _sequelize.Sequelize.fn('now')
      }
    }, {
      sequelize,
      tableName: 'audit_logs',
      schema: 'public',
      timestamps: false,
      indexes: [
        {
          name: 'audit_logs_pkey',
          unique: true,
          fields: [
            { name: 'id' },
          ]
        },
        {
          name: 'idx_audit_logs_actor_user_id',
          fields: [
            { name: 'actor_user_id' },
          ]
        },
        {
          name: 'idx_audit_logs_action_created_at',
          fields: [
            { name: 'action' },
            { name: 'created_at' },
          ]
        },
        {
          name: 'idx_audit_logs_feature_area_created_at',
          fields: [
            { name: 'feature_area' },
            { name: 'created_at' },
          ]
        },
      ]
    });
  }
}
