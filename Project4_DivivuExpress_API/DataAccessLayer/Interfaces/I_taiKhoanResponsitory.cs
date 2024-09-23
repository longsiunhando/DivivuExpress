using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer.Interfaces
{
    public partial interface I_taiKhoanResponsitory
    {
        List<taiKhoanModel> GetAllTaiKhoanModels();
        List<taiKhoanModel> GetTaiKhoanModels(string str);
        taiKhoanModel GetTaiKhoanModel(string Username);
        public bool Create_taiKhoan(taiKhoanModel taiKhoanModel);
        public bool Update_taiKhoan(taiKhoanModel taiKhoanModel);
        public bool Delete_taiKhoan(string username, string pass);
    }
}
