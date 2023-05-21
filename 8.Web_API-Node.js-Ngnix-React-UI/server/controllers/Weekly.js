import Weeksly from "../models/Weekly.js";
import User from "../models/UserModel.js";
import { Op } from "sequelize";

// get user data
export const WeekslyData = async (req, res) => {
  const { ssno } = req.params;

  try {
    let response;
    response = await Weeksly.findAll({
      attributes: [
        "facility",
        "district",
        "date",
        "active",
        "capacitive",
        "inductive",
        "ssno",
        "userId",
        "active_cons",
        "inductive_cons",
        "capacitive_cons",
        "inductive_ratio",
        "capacitive_ratio",
        "penalized",
      ],
      where: {
        ssno,
      },
      order: [["penalized", "DESC"]],
    });
    res.status(200).json(response);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};
