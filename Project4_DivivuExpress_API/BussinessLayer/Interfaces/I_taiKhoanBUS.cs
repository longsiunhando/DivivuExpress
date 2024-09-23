using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BussinessLayer.Interfaces
{
    public partial interface I_taiKhoanBUS
    {
        List<taiKhoanModel> GetAllTaiKhoanModels();
        List<taiKhoanModel> GetTaiKhoanModels(string str);
    }
}
