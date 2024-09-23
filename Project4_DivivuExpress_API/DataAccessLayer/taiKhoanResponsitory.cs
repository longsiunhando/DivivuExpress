using DataAccessLayer.Interfaces;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public partial class taiKhoanResponsitory : I_taiKhoanResponsitory
    {
        public IDatabaseHelper _dbHelper;
        public taiKhoanResponsitory(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }


        public List<taiKhoanModel> GetAllTaiKhoanModels()
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_get_all_taKhoan");
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<taiKhoanModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        
        public List<taiKhoanModel> GetTaiKhoanModels(string str) 
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_taKhoan_get_by_str",
                     "@str", str);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<taiKhoanModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public taiKhoanModel GetTaiKhoanModel(string Username)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sb_get_one_taiKhoan",
                     "@username", Username);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<taiKhoanModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}
