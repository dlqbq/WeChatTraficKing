
from bdb import effective
import csv
import os
import tkinter as tk
from tkinter import *
from tkinter import filedialog
import traceback
from typing import List

from PropertiesUtil import Properties

dictProperties = Properties('./config.properties').getProperties()

print(dictProperties)

window =tk.Tk()
#设置窗口title
window.title('金钱滚滚来，荷包天天满，身体都健康')
#设置窗口大小:宽x高,注,此处不能为 '*',必须使用 'x'
window.geometry('800x600')
# 获取电脑屏幕的大小
# print('电脑的分辨率是%dx%d'%(window.winfo_screenwidth(),window.winfo_screenheight()))
# 要求窗口的大小，必须先刷新一下屏幕
# window.update()
# print('窗口的分辨率是%dx%d'%(window.winfo_width(),window.winfo_height()))
# 如使用该函数则窗口不能被拉伸
window.resizable(0,0)
# 改变背景颜色
# window.config(background='#6fb765')
# 设置窗口处于顶层
window.attributes('-topmost',False)
# 设置窗口的透明度
window.attributes('-alpha',1)
# 设置全屏
# window.state('zoomed')
# 设置窗口被允许最大调整的范围，与resizble()冲突
# window.maxsize(600,600)
# 设置窗口被允许最小调整的范围，与resizble()冲突
window.minsize(800,600)
#更改左上角窗口的的icon图标,加载C语言中文网logo标
window.iconbitmap('./favicon.ico')
# #添加文本内容,并对字体添加相应的格式 font(字体,字号,'字体类型')
# text=tk.Label(window,text='金钱滚滚来，荷包天天满，身体都健康',bg='yellow',fg='red',font=('Times', 15, 'bold italic underline'))
# #将文本内容放置在主窗口内
# text.pack()


#创建一个frame窗体对象，用来包裹标签
# frame = Frame (window, relief=SUNKEN, borderwidth=0, width=window.winfo_width(), height=window.winfo_height())
frame = Frame (window, relief=SUNKEN, borderwidth=0)
# 在水平、垂直方向上填充窗体
frame.pack (side=TOP, fill=X, padx='8px', pady='16px')
# frameLeftStart = 20
# frameTopStart = 20
# frame.place(x=frameLeftStart, y=frameTopStart)

############################################### 选择数据文件夹 start ##############################################
# 初始化Entry控件的textvariable属性值
select_path = tk.StringVar()
# 设置默认数据文件夹
select_path.set(dictProperties['defaultDataFolder'])

def select_folder():
    # 文件夹选择
    selected_folder = filedialog.askdirectory()  # 使用askdirectory函数选择文件夹
    select_path.set(selected_folder)

selectDataFolderLabel = tk.Label(frame, text='请选择数据文件夹：')
selectDataFolderLabel.grid(column=0, row=0, rowspan=1)

selectDataFolderEntry = tk.Entry(frame, textvariable = select_path, width=int(window.winfo_width()* 0.08))
selectDataFolderEntry.grid(column=1, row=0, rowspan=1)

# 文件夹选择, 使用askdirectory函数选择文件夹
selectDataFolderButton = tk.Button(frame, text='选择文件夹', command=select_folder)
selectDataFolderButton.grid(column=2, row=0, rowspan=1)
############################################### 选择数据文件夹 end ##############################################


############################################### 处理日志 start###########################################
# data_log = tk.StringVar()
def update_log(new_log):
    print(new_log)
    # data_log.set('%s\n%s'%(data_log.get(), str(new_log)))
    # logText.insert('end', data_log.get())
    logText.insert('end', str(new_log) + '\n')
    logText.see('end')
    window.update()
############################################### 处理日志 end###########################################

############################################### 处理文件 start###########################################

def get_filelist(path):
    '''
    获取路径下所有csv文件的路径列表
    '''
    Filelist = []
    for home, dirs, files in os.walk(path):
        for filename in files:
            if '.csv' in filename:
                Filelist.append(os.path.join(home, filename))
    return Filelist

def read_csv_file(fileName):
    '''
    逐个读取文件的内容
    '''
    RowList = []
    with open(fileName, encoding='gbk', errors='ignore') as f:
        f_csv = csv.DictReader(f)
        for row in f_csv:
            RowList.append(row)
    return RowList

class ServiceDailyData():
    phoneNum: str = ''
    serviceDayNum: int = 0
    tapTimes: int = 0
    effectiveTapTimes: int = 0
    serviceDays: List[str]= []

    # def __init__(self) -> None:
    #     pass

    # def __init__(self, phoneNum: str, serviceDayNum: int = 0, tapTimes: int = 0, serviceDays = []) -> None:
    #     self.phoneNum = phoneNum
    #     self.serviceDayNum = serviceDayNum
    #     self.serviceDays = serviceDays
    #     self.tapTimes = tapTimes

    def __str__(self) -> str:
        return '(电话=%s,有效点击数=%s,服务日数=%s,点击数=%s,服务日期=%s'%(self.phoneNum, self.effectiveTapTimes, self.serviceDayNum, self.tapTimes, str(self.serviceDays))


def parse_data(RowList):
    ServiceDailyDataList: List[ServiceDailyData] = []
    for row in RowList:
        phoneNum = row[dictProperties['phoneNumberKey']]
        serviceDay = row[dictProperties['serviceDayKey']]

        result: ServiceDailyData = None
        for serviceDailyData in ServiceDailyDataList:
            if serviceDailyData.phoneNum == phoneNum:
                result = serviceDailyData

        if (result == None):
            result = ServiceDailyData()
            ServiceDailyDataList.append(result)

        result.phoneNum = phoneNum
        result.serviceDayNum = 1
        
        if (not serviceDay in result.serviceDays):
            result.serviceDays.append(serviceDay)

        result.tapTimes = result.tapTimes + 1
        if (result.effectiveTapTimes < int(dictProperties['maxDailyTapNum'])):
            result.effectiveTapTimes = result.effectiveTapTimes + 1

    return ServiceDailyDataList

def read_files(folder_path):
    '''
    读取文件并转换
    '''
    update_log('读取文件夹： %s'%(folder_path))
    Filelist = get_filelist(path=folder_path)
    for filename in Filelist:
        try:
            update_log('读取文件：%s'%(filename))
            RowList = read_csv_file(filename)
            ServiceDailyDataList: List[ServiceDailyData] = parse_data(RowList)
            for serviceDailyData in ServiceDailyDataList:
                update_log(serviceDailyData)
        except BaseException as e:
            print(e.args)
            print(traceback.format_exc())
            update_log('%s存在问题，请检查！'%(filename))

    return ''

def analyse_data():
    # path = './data/'
    # # fileName = path + '1662191134359.csv'
    # # fileName = path + '11662191134359.csv'
    # fileName = path + 'test.txt'
    # # f = csv.writer(codecs.open(fileName, mode='rb+', encoding='gbk', errors='ignore'), lineterminator='\n')
    # with open(fileName, encoding='gbk', errors='ignore') as f:
    #     f_csv = csv.DictReader(f)
    #     for row in f_csv:
    #         print(row)

    # data_log.set('')
    startAnalysDataButton.config(state='disabled')

    # 清空log
    logText.delete('1.0', END)

    # update_log('asdf')
    # logText.after(1000, logText.config(text = data_log.get()))
    # update_log('zxcv')
    # logText.after(1000, logText.config(text = data_log.get()))
    # update_log('qwer')
    # logText.after(1000, logText.config(text = data_log.get()))
    # update_log('fghj')
    # logText.after(1000, logText.config(text = data_log.get()))

    folder_path = select_path.get()
    if (not folder_path):
        folder_path = dictProperties.defaultDataFolder 
        
    try:
        read_files(folder_path)
    except Exception as e:
        update_log('请重试！')


    startAnalysDataButton.config(state='normal')
    return ''

############################################### 处理文件 end###########################################

startAnalysDataButton = tk.Button(frame,text='开始', command=analyse_data, padx='20px')
startAnalysDataButton.grid(column=1, row=1, rowspan=1, pady='16px')



############################################### 处理log start##########################################

#创建一个frame窗体对象，用来包裹标签
logFrame = Frame (window, relief=SUNKEN, borderwidth=0, width=window.winfo_width())
logFrame.pack (fill=BOTH, padx='8px')

logText = tk.Text(logFrame)
logScrollBar = tk.Scrollbar(logFrame)
logScrollBar.pack(side=RIGHT, fill=Y)

logScrollBar.config(command=logText.yview)

# logText.grid(column=0, row=3, columnspan=5)
logText.pack(fill=BOTH)
logText.config(yscrollcommand=logScrollBar.set)


# # 添加按钮，以及按钮的文本，并通过command 参数设置关闭窗口的功能
# button=tk.Button(window,text='关闭',command=window.quit)
# # 将按钮放置在主窗口内
# button.pack(side='bottom')


#进入主循环，显示主窗口
window.mainloop()