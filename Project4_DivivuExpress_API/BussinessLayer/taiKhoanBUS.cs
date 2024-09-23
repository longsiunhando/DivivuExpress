using BussinessLayer.Interfaces;
using DataAccessLayer;
using DataAccessLayer.Interfaces;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BussinessLayer
{
    public partial class taiKhoanBUS : I_taiKhoanBUS
    {
        public I_taiKhoanResponsitory _res;
        public taiKhoanBUS(I_taiKhoanResponsitory _TaiKhoanResponsitory)
        {
            _res = _TaiKhoanResponsitory;
        }
        public List<taiKhoanModel> GetAllTaiKhoanModels()
        {
            return _res.GetAllTaiKhoanModels();
        }
        public List<taiKhoanModel> GetTaiKhoanModels(string str)
        {
            return _res.GetTaiKhoanModels(str);
        }
    }
}
